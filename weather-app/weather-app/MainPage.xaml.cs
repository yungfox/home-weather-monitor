using Firebase.Database;
using Firebase.Database.Query;
using Firebase.Auth;
using Firebase.Auth.Providers;
using System.Diagnostics;
using System.Reactive.Linq;

namespace weather_app;

public partial class MainPage : ContentPage
{
    private FirebaseClient db;
    private static string noDataMessage = "updating...";
    private string _temp = noDataMessage;
    private string _hum = noDataMessage;
    private string _idx = noDataMessage;

    public string temp_update
    {
        get => _temp;
        set
        {
            _temp = value;
            OnPropertyChanged(nameof(temp_update));
        }
    }
    public string hum_update
    {
        get => _hum;
        set
        {
            _hum = value;
            OnPropertyChanged(nameof(hum_update));
        }
    }
    public string idx_update
    {
        get => _idx;
        set
        {
            _idx = value;
            OnPropertyChanged(nameof(idx_update));
        }
    }

    public MainPage()
    {
        InitializeComponent();

        this.BindingContext = this;
        temperature.SetBinding(Label.TextProperty, nameof(temp_update));
        humidity.SetBinding(Label.TextProperty, nameof(hum_update));
        heat_index.SetBinding(Label.TextProperty, nameof(idx_update));

        initFirebase().Wait();
    }

    public async Task initFirebase()
    {
        //initialize firebase client with credentials retrieved from Secrets.cs
        db = new FirebaseClient(Secrets.DATABASEURL, new FirebaseOptions { AuthTokenAsyncFactory = () => loginAsync() });

        //execute query and subscribe to changes
        var query = db.Child("firemqtt")
                    .OrderByKey()
                    .LimitToLast(1)
                    .AsObservable<Reading>()
                    //subscription callback
                    .Subscribe(res =>
                    {
                        //get properties of the object returned from the subscription
                        var r = res.Object;

                        //update textboxes with the latest data
                        temp_update = $"{r.Temperature} °C";
                        hum_update = $"{r.Humidity}%";
                        idx_update = $"{Math.Round(r.Heat_Index, 1)} °C";
                    });
    }

    public async Task<string> loginAsync()
    {
        //build firebase auth configuration object
        var config = new FirebaseAuthConfig
        {
            ApiKey = Secrets.APIKEY,
            AuthDomain = Secrets.AUTHDOMAIN,
            Providers = new FirebaseAuthProvider[] { new EmailProvider() }
        };

        //initialize auth client
        var client = new FirebaseAuthClient(config);

        //sign in the user
        var user = await client.SignInWithEmailAndPasswordAsync(Secrets.FIREBASEUSER, Secrets.FIREBASEPASSWORD);

        //client.AuthStateChanged += Client_AuthStateChanged;

        //return the user id token retrieved from firebase auth
        return await user.User.GetIdTokenAsync();
    }

    private void Client_AuthStateChanged(object sender, UserEventArgs e)
    {
        if (e.User != null)
        {
            Debug.WriteLine("!!!!!!!!!!!!!!!!! YEA !!!!!!!!!!!!!!!!");
        }
        else
        {
            Debug.WriteLine("!!!!!!!!!!!!!!!!! :( !!!!!!!!!!!!!!!!");
        }
    }
}

