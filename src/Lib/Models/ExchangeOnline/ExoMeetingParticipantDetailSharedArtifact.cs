using System.Text.Json.Serialization;

namespace SmallsOnline.TeamsAttendance.Lib.Models.ExchangeOnline;

public class ExoMeetingParticipantDetailSharedArtifact : IExoMeetingParticipantDetailSharedArtifact
{
    [JsonPropertyName("ArtifactSharedName")]
    public string ArtifactSharedName { get; set; } = null!;
}