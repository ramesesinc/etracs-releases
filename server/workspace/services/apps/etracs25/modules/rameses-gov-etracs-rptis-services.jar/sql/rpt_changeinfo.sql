[updatePropertyInfo]
update realproperty set
	cadastrallotno = $P{cadastrallotno},
	blockno = $P{blockno},
	surveyno = $P{surveyno},
	street = $P{street},
	purok = $P{purok},
	north = $P{north},
	south = $P{south},
	east = $P{east},
	west = $P{west}
where objid = $P{rpid}


[updateLedgerPropertyInfo]
update rptledger set
	cadastrallotno = $P{cadastrallotno}
where faasid = $P{faasid}	


[updateFaasInfo]
update faas set 
	tdno 		= $P{tdno},
	utdno 		= $P{utdno},
	titleno 	= $P{titleno},
	titledate 	= $P{titledate},
	restrictionid 	= $P{restrictionid},
	effectivityyear = $P{effectivityyear},
	effectivityqtr 	= $P{effectivityqtr},
	memoranda 		= $P{memoranda}
where objid = $P{faasid}	

[updateFaasPreviousInfo]
update faas set 
	prevtdno  = $P{prevtdno},
	prevpin  = $P{prevpin},
	prevowner  = $P{prevowner},
	prevav  = $P{prevav},
	prevmv  = $P{prevmv},
	prevadministrator  = $P{prevadministrator},
	prevareaha  = $P{prevareaha},
	prevareasqm  = $P{prevareasqm},
	preveffectivity  = $P{preveffectivity}
where objid = $P{faasid}	


[updateLedgerInfo]
update rptledger set 
	tdno = $P{tdno},
	titleno = $P{titleno}
where faasid = $P{faasid}

[updateLedgerFaasInfo]
update rptledgerfaas set 
	tdno = $P{tdno},
	fromyear = $P{effectivityyear},
	fromqtr = $P{effectivityqtr}
where faasid = $P{faasid}

[updateRpuInfo]
update rpu set 
	classification_objid  = $P{classificationid}
where objid = $P{rpuid}


[updateFaasOwnerInfo]
update faas set 
	taxpayer_objid = $P{taxpayer_objid},
	taxpayer_name = $P{taxpayer_name},
	taxpayer_address = $P{taxpayer_address},
	owner_name = $P{owner_name},
	owner_address = $P{owner_address},
	administrator_objid = $P{administrator_objid},
	administrator_name = $P{administrator_name},
	administrator_address = $P{administrator_address}
where objid = $P{faasid}

[updateLedgerOwnerInfo]
update rptledger set 
	taxpayer_objid = $P{taxpayer_objid},
	owner_name = $P{owner_name}
where faasid = $P{faasid}
