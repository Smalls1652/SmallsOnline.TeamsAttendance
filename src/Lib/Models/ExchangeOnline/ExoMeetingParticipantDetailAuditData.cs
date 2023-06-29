using System.Text.Json;
using System.Text.Json.Serialization;

namespace SmallsOnline.TeamsAttendance.Lib.Models.ExchangeOnline;

public class ExoMeetingParticipantDetailAuditData : IExoMeetingParticipantDetailAuditData
{
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

    [JsonPropertyName("ArtifactsShared")]
    public ExoMeetingParticipantDetailSharedArtifact[]? ArtifactsShared { get; set; }

    [JsonPropertyName("Attendees")]
    public ExoMeetingParticipantDetailAttendeeItem[]? Attendees { get; set; }

    [JsonPropertyName("JoinTime")]
    public DateTime JoinTime { get; set; }

    [JsonPropertyName("LeaveTime")]
    public DateTime LeaveTime { get; set; }

    [JsonPropertyName("IsJoinedFromLobby")]
    public bool IsJoinedFromLobby { get; set; }

    [JsonPropertyName("MeetingDetailId")]
    public string MeetingDetailId { get; set; } = null!;

    [JsonPropertyName("ItemName")]
    public string ItemName { get; set; } = null!;

    public override string ToString()
    {
        return $"{Operation} - {Id}";
    }

    public static ExoMeetingParticipantDetailAuditData FromJson(string json)
    {
        JsonSourceGenerationContext jsonSourceGenerationContext = new();

        return JsonSerializer.Deserialize(
            json: json,
            jsonTypeInfo: jsonSourceGenerationContext.ExoMeetingParticipantDetailAuditData
        )!;
    }
}