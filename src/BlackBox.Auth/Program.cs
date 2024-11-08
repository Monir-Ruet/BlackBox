using System.Text.Json.Serialization;
using Azure.Identity;
using Dapr;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services
    .AddControllers()
    .AddDapr();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// var env = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT");
// var tenantId = Environment.GetEnvironmentVariable("AZURE_TENANT_ID") ?? "d71d1097-e13c-4462-bd45-efb784b44264";

// var appConfigurationUrl = Environment.GetEnvironmentVariable("AZURE_APPCONFIGURATION_ENDPOINT");
// var appConfigurationClientId = Environment.GetEnvironmentVariable("AZURE_APPCONFIGURATION_CLIENTID") ?? "f0c6d911-101d-4654-a2ec-492160af09aa";

// builder.Configuration.AddAzureAppConfiguration(options =>
// {
//     options.Connect(appConfigurationUrl)
//         .Select("*", labelFilter: env)
//         // We don't need to refresh from key vault very often.
//         // This could possibly be increased up from 1 hour.
//         .ConfigureRefresh(appConfigurationRefreshOptions =>
//         {
//             // Watch for this one app configuration.
//             // When it changes, refresh all of the app settings.
//             appConfigurationRefreshOptions.Register("*", label: env, refreshAll: true);
//             appConfigurationRefreshOptions.SetRefreshInterval(TimeSpan.FromHours(1));
//         });
// });

// Console.WriteLine(builder.Configuration["AppName"]);

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();
app.MapSubscribeHandler();
app.UseCloudEvents();

app.MapPost("/orders", (Order order) =>
{
    Console.WriteLine("Subscriber received : " + order);
    return Results.Ok(order);
}).WithTopic("pubsub", "orders");

app.MapGet("/", () => "Hello from Auth.");
app.MapGet("/monir", () => "Hello from Monir.");
app.Run();

public record Order([property: JsonPropertyName("orderId")] int OrderId);
