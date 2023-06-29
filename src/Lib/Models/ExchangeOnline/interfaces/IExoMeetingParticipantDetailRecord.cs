namespace SmallsOnline.TeamsAttendance.Lib.Models.ExchangeOnline;

public interface IExoMeetingParticipantDetailRecord
{
    string RecordType { get; set; }
    DateTime CreationDate { get; set; }
    string UserIds { get; set; }
    string Operations { get; set; }
    string Identity { get; set; }
    ExoMeetingParticipantDetailAuditData AuditData { get; set; }
}