﻿-- =============================================
-- Author:		Kevin J. Dugan Jr
-- Create date: 2017 JULY 3
-- Description:	Select rushing stats
-- =============================================

CREATE PROCEDURE [dbo].[StatsRushingByWeek_select] @stageIndex INT, 
										@playerId   INT, 
										@leagueId   INT
AS
    BEGIN
	   -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	   SET NOCOUNT ON;
	   SELECT 
			t.displayName AS teamName, 
			s.playerid, 
			p.firstName, 
			p.lastName, 
			p.position, 
			s.seasonIndex, 
			(SELECT 
				   abbrName
				   FROM 
					   tblTeamInfo
				   WHERE teamid = sch.awayTeamId
					    AND leagueId = @leagueId) AS Away, 
			(SELECT 
				   abbrName
				   FROM 
					   tblTeamInfo
				   WHERE teamid = sch.homeTeamId
					    AND leagueId = @leagueId) AS Home, 
			(s.weekIndex) AS 'Week', 
			(rush20PlusYds) AS '20Plus', 
			(rushAtt) AS 'Attempt', 
			(rushBrokenTackles) AS 'BrokenTackle', 
			(rushFum) AS 'Fumble', 
			(rushYds) AS 'Yards', 
			(rushYdsAfterContact) AS 'YardsAfterContact', 
			(rushTDs) AS 'Touchdown', 
			(rushLongest) AS 'Longest'
			FROM 
				tblStatsRushing AS s
			LEFT JOIN tblTeamInfo AS t
				ON t.teamId = s.teamId
				   AND t.leagueId = s.leagueId
			LEFT JOIN tblPlayerProfile AS p
				ON p.playerId = s.playerId
				   AND p.leagueId = s.leagueId
			JOIN tblSchedule AS sch
				ON sch.scheduleID = s.scheduleid
				   AND sch.weekindex = s.weekindex
				   AND sch.seasonindex = s.seasonindex
				   AND sch.leagueId = s.leagueId
			WHERE s.stageIndex = @stageIndex
				 AND s.playerId = @playerId
				 AND s.leagueId = @leagueId
			ORDER BY 
				    s.SeasonIndex DESC, 
				    Week;
    END;