[getLandAppraisals]
SELECT
	pc.code AS classcode,
	pc.name  AS classname,
	spc.code AS specificcode,
	spc.name AS specificname,
	sub.code AS subcode, 
	sub.name AS subname, 
	al.code AS actualusecode,
	al.name AS actualusename,
	ld.areasqm, 
	ld.areaha,
	CASE WHEN ld.areatype = 'HA' THEN ld.areaha ELSE ld.areasqm END AS area,
	ld.unitvalue,
	ld.basemarketvalue,
	ld.areatype
FROM landdetail ld 
	INNER JOIN lcuvspecificclass spc ON ld.specificclass_objid = spc.objid 
	INNER JOIN lcuvsubclass sub ON ld.subclass_objid = sub.objid 
	INNER JOIN landassesslevel al ON ld.actualuse_objid = al.objid 
	INNER JOIN propertyclassification pc ON spc.classification_objid = pc.objid 
	LEFT JOIN lcuvstripping st on ld.stripping_objid = st.objid 
WHERE ld.landrpuid = $P{objid}	
ORDER BY st.striplevel, ld.objid DESC 


[getPlantTreeAppraisals]
SELECT
	ptd.areacovered,
	ptd.nonproductiveage,
	pt.name AS planttreename,
	ptuv.name AS subname, 
	ptd.nonproductive,
	ptd.productive,
	ptd.unitvalue,
	ptd.basemarketvalue
FROM planttreedetail ptd 	
	INNER JOIN planttree pt ON ptd.planttree_objid = pt.objid 
	INNER JOIN planttreeunitvalue ptuv  ON ptd.planttreeunitvalue_objid = ptuv.objid 
${filter}	
ORDER BY ptd.objid DESC 


[getLandDetails]
select 
	ld.objid, 
	sub.code as subclass_code, 
	sub.name as subclass_name,
	spc.code as specificclass_code, 
	spc.name as specificclass_name,
	au.code as actualuse_code, 
	au.name as actualuse_name,
	st.striplevel, 
	ld.striprate,
	ld.areatype,
	ld.area,
	ld.areasqm,
	ld.areaha,
	ld.basevalue,
	ld.unitvalue,
	ld.taxable,
	ld.basemarketvalue,
	ld.adjustment,
	ld.landvalueadjustment,
	ld.actualuseadjustment,
	ld.marketvalue,
	ld.assesslevel,
	ld.assessedvalue
from landdetail ld 
	inner join landassesslevel au on ld.actualuse_objid = au.objid 
	inner join lcuvspecificclass spc on ld.specificclass_objid = spc.objid 
	inner join lcuvsubclass sub on ld.subclass_objid = sub.objid 
	left join lcuvstripping st on ld.stripping_objid = st.objid 
where ld.landrpuid = $P{objid}


[getLandAdjustments]
SELECT
	la.objid, 
	la.expr,
	la.adjustment,
	la.type,
	lat.code AS adjustmenttype_code,
	lat.name AS adjustmenttype_name,
	lat.expr AS adjustmenttype_expr
FROM landadjustment la
	INNER JOIN landadjustmenttype lat ON la.adjustmenttype_objid = lat.objid 
WHERE la.landrpuid = $P{objid}
  AND la.type = 'LV'
ORDER BY lat.idx    


[getLandDetailAdjustments]
SELECT
	la.objid, 
	la.expr,
	la.adjustment,
	la.type,
	lat.code AS adjustmenttype_code,
	lat.name AS adjustmenttype_name,
	lat.expr AS adjustmenttype_expr
FROM landadjustment la
	INNER JOIN landadjustmenttype lat ON la.adjustmenttype_objid = lat.objid 
WHERE la.landdetailid = $P{objid}
  AND la.type = 'AU'
ORDER BY lat.idx    


[getAdjustmentParameters]  
select 
	lp.param_objid,
	lp.value,
	rp.name AS param_name, rp.paramtype AS param_paramtype,
	rp.caption AS param_caption
FROM landadjustmentparameter lp 
	INNER JOIN rptparameter rp ON lp.param_objid = rp.objid 
WHERE lp.landadjustmentid = $P{objid}



[getPlantTrees]  
SELECT 
	ptd.objid,
	ptd.productive,
	ptd.nonproductive,
	ptd.nonproductiveage,
	ptd.unitvalue,
	ptd.basemarketvalue,
	ptd.adjustment,
	ptd.adjustmentrate,
	ptd.marketvalue,
	ptd.assesslevel,
	ptd.assessedvalue,
	ptd.areacovered,
	puv.code AS planttreeunitvalue_code,
	puv.name AS planttreeunitvalue_name,
	puv.unitvalue AS planttreeunitvalue_unitvalue,
	pt.code AS planttree_code,
	pt.name AS planttree_name,
	al.code AS actualuse_code,
	al.name AS actualuse_name,
	al.rate AS actualuse_rate,
	pc.objid AS actualuse_classification_objid,
	pc.code AS actualuse_classification_code,
	pc.name AS actualuse_classification_name
FROM planttreedetail ptd
	INNER JOIN planttreeunitvalue puv ON ptd.planttreeunitvalue_objid = puv.objid 
	INNER JOIN planttree pt ON ptd.planttree_objid = pt.objid 
	INNER JOIN planttreeassesslevel al ON ptd.actualuse_objid = al.objid 
	INNER JOIN propertyclassification pc ON al.classification_objid = pc.objid 
WHERE ptd.landrpuid	= $P{objid} 
order by ptd.objid DESC 


[getLandPropertyAssessments]
SELECT 
	x.classcode,
	x.classname,
	x.actualuse,
	x.actualusename,
	x.assesslevel, 
	x.assesslevelrate,
	sum(x.marketvalue) as marketvalue,
	sum(x.assessedvalue) as assessedvalue
FROM (
	SELECT 
		pc.code as classcode,
		pc.name as classname, 
		lal.code AS actualuse,
		lal.name AS actualusename,
		ra.marketvalue,
		ra.assesslevel / 100 AS assesslevel,
		ra.assesslevel AS assesslevelrate,
		ra.assessedvalue AS assessedvalue 
	FROM rpu_assessment ra 
		INNER JOIN landassesslevel lal ON ra.actualuse_objid = lal.objid 
		inner join propertyclassification pc on lal.classification_objid = pc.objid 
	WHERE ra.rpuid = $P{objid}	

	UNION ALL 

	SELECT 
		pc.code as classcode,
		pc.name as classname,
		lal.code AS actualuse,
		lal.name AS actualusename,
		ra.marketvalue,
		ra.assesslevel / 100 AS assesslevel,
		ra.assesslevel AS assesslevelrate,
		ra.assessedvalue AS assessedvalue 
	FROM rpu_assessment ra 
		INNER JOIN planttreeassesslevel lal ON ra.actualuse_objid = lal.objid 
		INNER JOIN propertyclassification pc on lal.classification_objid = pc.objid 
	WHERE ra.rpuid = $P{objid}	
) x 
group by 
	x.classcode,
	x.classname,
	x.actualuse,
	x.actualusename,
	x.assesslevel, 
	x.assesslevelrate



[getBackTaxes]
SELECT * FROM faasbacktax WHERE faasid = $P{objid} ORDER BY ry 


[getAdjustments]
select 
	x.*,
	lat.name as adjtypename
from (
	select 
		la.objid, 
		la.adjustmenttype_objid, 
		max(la.basemarketvalue) as basemarketvalue, 
		max(la.adjustment / la.basemarketvalue) as adjrate,
		sum(la.adjustment) as adjustment,
		sum(la.basemarketvalue + la.adjustment) as marketvalue
	from landadjustment la 
	where landrpuid = $P{objid}
	group by la.objid, la.adjustmenttype_objid, la.basemarketvalue 
)x 
inner join landadjustmenttype lat on x.adjustmenttype_objid = lat.objid 
order by lat.idx 

[findPlantTreeAdjustment]
select 
	adjustmentrate / 100.0 as adjrate, 
	sum(basemarketvalue) as basemarketvalue,
	sum(adjustment) as adjustment,
	sum(marketvalue) as marketvalue
from planttreedetail 
where landrpuid = $P{objid}
group by adjustmentrate