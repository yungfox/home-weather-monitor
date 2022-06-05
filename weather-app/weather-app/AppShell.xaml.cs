namespace weather_app;

public partial class AppShell : Shell
{
    public AppShell()
    {
        InitializeComponent();
    }

    private void ThemeButton_Clicked(object sender, EventArgs e)
    {
        if (Application.Current.UserAppTheme == AppTheme.Light)
            Application.Current.UserAppTheme = AppTheme.Dark;
        else
            Application.Current.UserAppTheme = AppTheme.Light;
    }
}
