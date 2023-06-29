namespace SmallsOnline.TeamsAttendance.Lib.Models.ExchangeOnline;

public interface IExoMeetingParticipantDetailAttendeeItem
{
    string OrganizationId { get; set; }
    string RecipientType { get; set; }
    string UserObjectId { get; set; }
    string DisplayName { get; set; }
    string UserPrincipalName { get; set; }
}