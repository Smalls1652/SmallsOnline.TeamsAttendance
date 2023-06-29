using System.Text.Json.Serialization;

namespace SmallsOnline.TeamsAttendance.Lib.Models.ExchangeOnline;

public class ExoMeetingParticipantDetailRecord : IExoMeetingParticipantDetailRecord
{
    [JsonPropertyName("RecordType")]
    public string RecordType { get; set; } = null!;

    [JsonPropertyName("CreationDate")]
    public DateTime CreationDate { get; set; }

    [JsonPropertyName("UserIds")]
    public string UserIds { get; set; } = null!;

    [JsonPropertyName("Operations")]
    public string Operations { get; set; } = null!;

    [JsonPropertyName("Identity")]
    public string Identity { get; set; } = null!;

    [JsonPropertyName("AuditData")]
    public ExoMeetingParticipantDetailAuditData AuditData { get; set; } = null!;
}