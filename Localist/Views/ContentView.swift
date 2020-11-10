import SwiftUI
import Request
import Combine
import CoreLocation

class LocationViewModel: NSObject, ObservableObject{
  
  @Published var userLatitude: String = "0"
  @Published var userLongitude: String = "0"
  
  private let locationManager = CLLocationManager()
  
  override init() {
    super.init()
    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.requestAlwaysAuthorization()
    
    if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways){
        self.retriveCurrentLocation()
    }
  }
    
    func retriveCurrentLocation(){
        let status = CLLocationManager.authorizationStatus()
        
        if(status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()){
            return
        }
        
        // if haven't show location permission dialog before, show it to user
        if(status == .notDetermined){
            locationManager.requestWhenInUseAuthorization()
            
            // if you want the app to retrieve location data even in background, use requestAlwaysAuthorization
            locationManager.requestAlwaysAuthorization()
            return
        }
        
        // request location data for one-off usage
        locationManager.requestLocation()
    }
}

extension LocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("location manager authorization status changed")
        
        switch status {
        case .authorizedAlways:
            print("user allow app to get location data when app is active or in background")
        case .authorizedWhenInUse:
            print("user allow app to get location data only when app is active")
        case .denied:
            print("user tap 'disallow' on the permission dialog, cant get location data")
        case .restricted:
            print("parental control setting disallow location data")
        case .notDetermined:
            print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // the last element is the most recent location
        if let location = locations.last {
            self.userLatitude = "\(location.coordinate.latitude)"
            self.userLongitude = "\(location.coordinate.longitude)"
        }
        print(self.userLatitude)
        print(self.userLongitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}

struct ContentView : View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var status: Int = 0
    @State private var showingAlert = false
    @State var showLoginView: Bool = false
    @State var showCreateUserView: Bool = false
    @State var users: [User] = []
    @State private var loggedIn: Bool
    @State private var userLatitude: String = ""
    @State private var userLongitude: String = ""
    
    @ObservedObject var locationViewModel = LocationViewModel()
    
    init()
    {
        let initialDefaults: NSDictionary =
        [
            "username": "username",
            "password": "password",
            "email": "email",
            "date_joined": "date_joined",
        ]
        UserDefaults.standard.register(defaults: initialDefaults as! [String : Any])
        
        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: defaultsKeys.username)!
        
        if username != "username"
        {
            self._loggedIn = State(initialValue: true)
        }
        else
        {
            self._loggedIn = State(initialValue: false)
        }
    }
    var body: some View {
        NavigationView()
        {
            ScrollView {
                HStack {
                    PageView(loggedIn: self.$loggedIn, userLatitude: self.$locationViewModel.userLatitude , userLongitude: self.$locationViewModel.userLongitude)
                }
            }
        }
    }
    
    private func isUserInformationValid() -> Bool
    {
        if username.isEmpty
        {
            return false
        }
        
        if password.isEmpty
        {
            return false
        }
        
        return true
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}

struct PageView: View {
    @Binding var loggedIn: Bool
    @Binding var userLatitude: String
    @Binding var userLongitude: String
    @State var size = UIScreen.main.bounds.width / 1.6
    
    @State private var categories = ["Deals", "Happy Hour", "Recreation", "What's Happening?", "Misc"]
    
    var body: some View {
        if #available(iOS 14.0, *) {
            TabView {
                ForEach(0 ..< categories.count) { i in
                    ZStack {
                        FeedView(loggedIn: self.$loggedIn, userLatitude: self.$userLatitude , userLongitude: self.$userLongitude, category: self.$categories[i])
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .tabViewStyle(PageTabViewStyle())
        } else {
            // Fallback on earlier versions
        }
    }
}

struct defaultsKeys {
    static let username = "username"
    static let password = "password"
    static let email = "email"
    static let date_joined = "date_joined"
}


class UserAuth: ObservableObject {
    let didChange = PassthroughSubject<UserAuth,Never>()

      // required to conform to protocol 'ObservableObject'
    let willChange = PassthroughSubject<UserAuth,Never>()

    @State private var showingAlert = false
       
    @Published var isLoggedin: Bool = false
        
    func login(username: String, password: String, users: [User]) -> Bool{
     
        API().getUser(username: username, password:  password){ (users) in
            if(users.count != 0)
            {
                
                let defaults = UserDefaults.standard
                defaults.set(username, forKey: defaultsKeys.username)
                defaults.set(password, forKey: defaultsKeys.password)
                defaults.set(users[0].email, forKey: defaultsKeys.email)
                defaults.set(users[0].date_joined, forKey: defaultsKeys.date_joined)
                self.isLoggedin = true
            }
            else
            {
                self.showingAlert = true
            }
        
        }
        return self.isLoggedin
    }
}

class GlobalLogin: ObservableObject {
  @Published var isLoggedIn = false
}
