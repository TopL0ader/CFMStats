﻿CREATE TABLE [dbo].[tblPlayerRatings]
(
	[playerId]                  INT NOT NULL, 
	[leagueId]                  INT NOT NULL,
    [CreatedOn]                 DATETIME2 NOT NULL,
    [ModifiedOn]                DATETIME2 NOT NULL,	
    [playerBestOvr]             INT NOT NULL, 
    [playerSchemeOvr]           INT NOT NULL, 
    [teamSchemeOvr]             INT NOT NULL, 
	[accelRating]               INT NOT NULL, 
	[agilityRating]             INT NOT NULL, 
	[awareRating]               INT NOT NULL, 
	[bCVRating]                 INT NOT NULL, 
	[blockShedRating]           INT NOT NULL, 
	[carryRating]               INT NOT NULL, 
	[catchRating]               INT NOT NULL, 
	[cITRating]                 INT NOT NULL, 
	[confRating]                INT NOT NULL, 
	[elusiveRating]             INT NOT NULL, 
	[finesseMovesRating]        INT NOT NULL, 
	[hitPowerRating]            INT NOT NULL, 
	[impactBlockRating]         INT NOT NULL, 
	[injuryRating]              INT NOT NULL, 
	[jukeMoveRating]            INT NOT NULL, 
	[jumpRating]                INT NOT NULL, 
	[kickAccRating]             INT NOT NULL, 
	[kickPowerRating]           INT NOT NULL, 
	[kickRetRating]             INT NOT NULL, 
	[manCoverRating]            INT NOT NULL, 
	[passBlockRating]           INT NOT NULL, 
	[playActionRating]          INT NOT NULL, 
	[playRecRating]             INT NOT NULL, 
	[powerMovesRating]          INT NOT NULL, 
	[pressRating]               INT NOT NULL, 
	[pursuitRating]             INT NOT NULL, 
	[releaseRating]             INT NOT NULL, 
	[routeRunRating]            INT NOT NULL, 
	[runBlockRating]            INT NOT NULL, 
	[specCatchRating]           INT NOT NULL, 
	[speedRating]               INT NOT NULL, 
	[spinMoveRating]            INT NOT NULL, 
	[staminaRating]             INT NOT NULL, 
	[stiffArmRating]            INT NOT NULL, 
	[strengthRating]            INT NOT NULL, 
	[tackleRating]              INT NOT NULL, 
	[throwAccDeepRating]        INT NOT NULL, 
	[throwAccMidRating]         INT NOT NULL, 
	[throwAccRating]            INT NOT NULL, 
	[throwAccShortRating]       INT NOT NULL, 
	[throwOnRunRating]          INT NOT NULL, 
	[throwPowerRating]          INT NOT NULL, 
	[toughRating]               INT NOT NULL, 
	[truckRating]               INT NOT NULL, 
	[zoneCoverRating]           INT NOT NULL,
	[breakSackRating]           INT NULL, 
	[breakTackleRating]         INT NULL, 
	[leadBlockRating]           INT NULL, 
	[passBlockFinesseRating]    INT NULL, 
	[passBlockPowerRating]      INT NULL, 
	[routeRunDeepRating]        INT NULL, 
	[routeRunMedRating]         INT NULL, 
	[routeRunShortRating]       INT NULL, 
	[runBlockFinesseRating]     INT NULL, 
	[runBlockPowerRating]       INT NULL, 
	[throwUnderPressureRating]  INT NULL,
	
	-- Constraints
	CONSTRAINT [FK_dbo.tblPlayerRatings_dbo.tblPlayerProfile] FOREIGN KEY([PlayerId]) REFERENCES [dbo].[tblPlayerProfile]([PlayerId]), 
    PRIMARY KEY ([playerId])
)