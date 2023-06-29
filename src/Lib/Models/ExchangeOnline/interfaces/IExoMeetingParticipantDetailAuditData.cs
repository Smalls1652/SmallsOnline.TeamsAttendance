namespace SmallsOnline.TeamsAttendance.Lib.Models.ExchangeOnline;

public interface IExoMeetingParticipantDetailAuditData
{
    DateTime CreationTime { get; set; }
    string Id { get; set; }
    string Operation { get; set; }
    string OrganizationId { get; set; }
    string UserKey { get; set; }
    string Workload { get; set; }
    string ClientIp { get; set; }
    string UserId { get; set; }
    ExoMeetingParticipantDetailSharedArtifact[]? ArtifactsShared { get; set; }
    ExoMeetingParticipantDetailAttendeeItem[]? Attendees { get; set; }
    DateTime JoinTime { get; set; }
    DateTime LeaveTime { get; set; }
    bool IsJoinedFromLobby { get; set; }
    string MeetingDetailId { get; set; }
    string ItemName { get; set; }
}