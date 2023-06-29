using System.Text.Json;
using System.Text.Json.Serialization;

namespace SmallsOnline.TeamsAttendance.Lib.Models.ExchangeOnline;

public class ExoMeetingDetailAuditData : IExoMeetingDetailAuditData
{
    public ExoMeetingDetailAuditData()
    {}

    [JsonPropertyName("CreationTime")]
    public DateTime CreationTime { get; set; }

    [JsonPropertyName("Id")]
    public string Id { get; set; } = null!;

    [JsonPropertyName("Operation")]
    public string Operation { get; set; } = null!;

    [JsonPropertyName("OrganizationId")]
    public string OrganizationId { get; set; } = null!;

    [JsonPropertyName("UserKey")]
    public string UserKey { get; set; } = null!;

    [JsonPropertyName("Workload")]
    public string Workload { get; set; } = null!;

    [JsonPropertyName("ClientIP")]
    public string ClientIp { get; set; } = null!;

    [JsonPropertyName("UserId")]
    public string UserId { get; set; } = null!;

    [JsonPropertyName("ChatThreadId")]
    public string ChatThreadId { get; set; } = null!;

    [JsonPropertyName("CommunicationType")]
    public string CommunicationType { get; set; } = null!;

    [JsonPropertyName("CommunicationSubType")]
    public string CommunicationSubType { get; set; } = null!;

    [JsonPropertyName("StartTime")]
    public DateTime StartTime { get; set; }

    [JsonPropertyName("EndTime")]
    public DateTime EndTime { get; set; }

    [JsonPropertyName("MeetingURL")]
    public string MeetingUrl { get; set; } = null!;

    [JsonPropertyName("ProviderTypes")]
    public string ProviderTypes { get; set; } = null!;

    [JsonPropertyName("ItemName")]
    public string ItemName { get; set; } = null!;

    public override string ToString()
    {
        return $"{Operation} - {Id}";
    }

    public static ExoMeetingDetailAuditData FromJson(string json)
    {
        JsonSourceGenerationContext jsonSourceGenerationContext = new();

        return JsonSerializer.Deserialize(
            json: json,
            jsonTypeInfo: jsonSourceGenerationContext.ExoMeetingDetailAuditData
        )!;
    }
}