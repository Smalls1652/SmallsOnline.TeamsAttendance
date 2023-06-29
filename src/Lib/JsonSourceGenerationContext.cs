using System.Text.Json.Serialization;
using SmallsOnline.TeamsAttendance.Lib.Models.ExchangeOnline;

namespace SmallsOnline.TeamsAttendance.Lib;

[JsonSourceGenerationOptions(
    WriteIndented = true,
    GenerationMode = JsonSourceGenerationMode.Default,
    DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull
)]
[JsonSerializable(typeof(ExoMeetingDetailRecord))]
[JsonSerializable(typeof(ExoMeetingDetailRecord[]))]
[JsonSerializable(typeof(ExoMeetingDetailAuditData))]
[JsonSerializable(typeof(ExoMeetingDetailAuditData[]))]
[JsonSerializable(typeof(ExoMeetingParticipantDetailRecord))]
[JsonSerializable(typeof(ExoMeetingParticipantDetailRecord[]))]
[JsonSerializable(typeof(ExoMeetingParticipantDetailAuditData))]
[JsonSerializable(typeof(ExoMeetingParticipantDetailAuditData[]))]
[JsonSerializable(typeof(ExoMeetingParticipantDetailAttendeeItem))]
[JsonSerializable(typeof(ExoMeetingParticipantDetailAttendeeItem[]))]
[JsonSerializable(typeof(ExoMeetingParticipantDetailSharedArtifact))]
[JsonSerializable(typeof(ExoMeetingParticipantDetailSharedArtifact[]))]
internal partial class JsonSourceGenerationContext : JsonSerializerContext
{
}