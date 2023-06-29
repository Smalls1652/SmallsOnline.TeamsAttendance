namespace SmallsOnline.TeamsAttendance.Lib.Models;

public interface IMeetingAttendee
{
    string UserId { get; set; }
    string UserPrincipalName { get; set; }
    string? DisplayName { get; set; }
    DateTime JoinTime { get; set; }
    DateTime LeaveTime { get; set; }
}