namespace SmallsOnline.TeamsAttendance.Lib.Models.ExchangeOnline;

public interface IExoMeetingDetailRecord
{
    string RecordType { get; set; }
    DateTime CreationDate { get; set; }
    string UserIds { get; set; }
    string Operations { get; set; }
    string Identity { get; set; }
    ExoMeetingDetailAuditData AuditData { get; set; }
}