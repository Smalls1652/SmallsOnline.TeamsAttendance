namespace SmallsOnline.TeamsAttendance.Lib.Models;

public interface IMeetingAttendance
{
    DateTime CreationTime { get; set; }
    string MeetingId { get; set; }
    string UserId { get; set; }
    string CommunicationType { get; set; }
    string CommunicationSubType { get; set; }
    DateTime StartTime { get; set; }
    DateTime EndTime { get; set; }
    string MeetingUrl { get; set; }
    MeetingAttendee[]? Attendees { get; set; }
}