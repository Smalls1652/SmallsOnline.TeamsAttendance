namespace SmallsOnline.TeamsAttendance.Lib.Models;

public interface IUserData
{
    string UserId { get; set; }
    string UserPrincipalName { get; set; }
    string? DisplayName { get; set; }
}