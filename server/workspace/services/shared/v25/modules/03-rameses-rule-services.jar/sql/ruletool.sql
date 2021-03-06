[findRule]
select * from sys_rule where objid=$P{ruleid} 

[getRuleConditions]
select rc.* from sys_rule r 
	inner join sys_rule_condition rc on r.objid=rc.parentid 
where r.objid=$P{ruleid} 

[getRuleConditionVars]
select rcv.* from sys_rule_condition rc 
	inner join sys_rule_condition_var rcv on rc.objid=rcv.parentid 
where rc.objid=$P{conditionid} 

[getRuleConditionConstraints]
select rcc.* from sys_rule_condition rc 
	inner join sys_rule_condition_constraint rcc on rc.objid=rcc.parentid 
where rc.objid=$P{conditionid} 

[getRuleActions]
select ra.* from sys_rule r 
	inner join sys_rule_action ra on r.objid=ra.parentid 
where r.objid=$P{ruleid} 

[getRuleActionParams]
select rap.* from sys_rule_action ra 
	inner join sys_rule_action_param rap on ra.objid=rap.parentid 
where ra.objid=$P{actionid} 

[updateRuleConditionConstraintListValue]
update sys_rule_condition_constraint set 
	listvalue = $P{listvalue} 
where 
	objid = $P{objid}  

[updateRuleActionParamListValue]
update sys_rule_action_param set 
	listvalue = $P{listvalue} 
where 
	objid = $P{objid}  
