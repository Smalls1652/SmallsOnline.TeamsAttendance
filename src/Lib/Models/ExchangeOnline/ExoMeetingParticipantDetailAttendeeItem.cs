using System.Text.Json.Serialization;

namespace SmallsOnline.TeamsAttendance.Lib.Models.ExchangeOnline;

public class ExoMeetingParticipantDetailAttendeeItem : IExoMeetingParticipantDetailAttendeeItem
{
    [JsonPropertyName("OrganizationId")]
    public string OrganizationId { get; set; } = null!;

    [JsonPropertyName("RecipientType")]
    public string RecipientType { get; set; } = null!;

    [JsonPropertyName("UserObjectId")]
    public string UserObjectId { get; set; } = null!;

    [JsonPropertyName("DisplayName")]
    public string DisplayName { get; set; } = null!;

    [JsonPropertyName("UPN")]
    public string UserPrincipalName { get; set; } = null!;
}