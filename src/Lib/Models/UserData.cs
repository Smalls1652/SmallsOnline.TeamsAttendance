using System.Text.Json.Serialization;

namespace SmallsOnline.TeamsAttendance.Lib.Models;

public class UserData : IUserData
{
    [JsonPropertyName("userId")]
    public string UserId { get; set; } = null!;

    [JsonPropertyName("userPrincipalName")]
    public string UserPrincipalName { get; set; } = null!;

    [JsonPropertyName("displayName")]
    public string? DisplayName { get; set; }
}