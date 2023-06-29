namespace SmallsOnline.TeamsAttendance.Lib.Models.ExchangeOnline;

public interface IExoMeetingDetailAuditData
{
    DateTime CreationTime { get; set; }
    string Id { get; set; }
    string Operation { get; set; }
    string OrganizationId { get; set; }
    string UserKey { get; set; }
    string Workload { get; set; }
    string ClientIp { get; set; }
    string UserId { get; set; }
    string ChatThreadId { get; set; }
    string CommunicationType { get; set; }
    string CommunicationSubType { get; set; }
    DateTime StartTime { get; set; }
    DateTime EndTime { get; set; }
    string MeetingUrl { get; set; }
    string ProviderTypes { get; set; }
    string ItemName { get; set; }
}