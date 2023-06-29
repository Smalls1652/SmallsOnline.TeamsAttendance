using System.Text.Json.Serialization;

namespace SmallsOnline.TeamsAttendance.Lib.Models;

public class MeetingAttendance : IMeetingAttendance
{
    [JsonPropertyName("creationTime")]
    public DateTime CreationTime { get; set; }

    [JsonPropertyName("meetingId")]
    public string MeetingId { get; set; } = null!;

    [JsonPropertyName("userId")]
    public string UserId { get; set; } = null!;

    [JsonPropertyName("communicationType")]
    public string CommunicationType { get; set; } = null!;

    [JsonPropertyName("communicationSubType")]
    public string CommunicationSubType { get; set; } = null!;

    [JsonPropertyName("startTime")]
    public DateTime StartTime { get; set; }

    [JsonPropertyName("endTime")]
    public DateTime EndTime { get; set; }

    [JsonPropertyName("meetingUrl")]
    public string MeetingUrl { get; set; } = null!;

    [JsonPropertyName("attendees")]
    public MeetingAttendee[]? Attendees { get; set; }
}