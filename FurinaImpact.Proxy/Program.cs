using FurinaImpactProxy;
using Newtonsoft.Json;

Console.Title = "FurinaImpact | Proxy";

string configJson;
try
{
    configJson = File.ReadAllText("./config.json");
}
catch (Exception)
{
    ProxyConfig defaultConfig = new();
    configJson = JsonConvert.SerializeObject(defaultConfig, Formatting.Indented);
    File.WriteAllText("./config.json", configJson);
}

if (string.IsNullOrWhiteSpace(configJson))
{
    Environment.Exit(-1);
    return;
}

ProxyConfig config;
try
{
    config = JsonConvert.DeserializeObject<ProxyConfig>(configJson);
}
catch (Exception)
{
    Environment.Exit(-1);
    return;
}

if (config == null)
{
    Environment.Exit(-1);
    return;
}

string host = config.HOST;
int port = config.PORT;

ProxyService service = new(config);

AppDomain.CurrentDomain.ProcessExit += (_, _) =>
{
    service.Shutdown();
};

while (true) { }
