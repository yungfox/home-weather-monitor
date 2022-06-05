namespace weather_app;

public static class MauiProgram
{
	public static MauiApp CreateMauiApp()
	{
		var builder = MauiApp.CreateBuilder();
		builder
			.UseMauiApp<App>()
			.ConfigureFonts(fonts =>
			{
                fonts.AddFont("LexendDeca-ExtraLight.ttf", "LexendDeca200");
                fonts.AddFont("LexendDeca-Light.ttf", "LexendDeca300");
                fonts.AddFont("LexendDeca-Regular.ttf", "LexendDeca400");
                fonts.AddFont("LexendDeca-Medium.ttf", "LexendDeca500");
                fonts.AddFont("LexendDeca-SemiBold.ttf", "LexendDeca600");
                fonts.AddFont("LexendDeca-Bold.ttf", "LexendDeca700");
            });

		return builder.Build();
	}
}
