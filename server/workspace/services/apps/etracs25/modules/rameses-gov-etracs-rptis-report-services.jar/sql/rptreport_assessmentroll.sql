[getAssessmentRollTaxable]
SELECT
	r.ry, rp.section,  
	CASE WHEN p.objid IS NOT NULL THEN p.name ELSE c.name END AS parentlguname, 
	CASE WHEN p.objid IS NOT NULL THEN p.indexno ELSE c.indexno END AS parentlguindex,   
	CASE WHEN m.objid IS NOT NULL THEN m.name ELSE d.name END AS lguname, 
	CASE WHEN m.objid IS NOT NULL THEN m.indexno ELSE d.indexno END AS lguindex,  
	
	b.name AS barangay, b.indexno AS barangayindex, 
	f.owner_name, f.owner_address, 
	f.administrator_name, f.administrator_address, 
	f.tdno, f.effectivityyear, 
	rp.cadastrallotno, rp.surveyno, rp.blockno, pc.code AS classcode, r.rputype, r.totalav, 
	r.fullpin, f.prevtdno, f.memoranda, rp.barangayid 
FROM faas f
	INNER JOIN rpu r ON f.rpuid = r.objid 
	INNER JOIN realproperty rp ON f.realpropertyid = rp.objid
	INNER JOIN propertyclassification pc ON r.classification_objid = pc.objid 
	INNER JOIN barangay b ON rp.barangayid = b.objid 
	LEFT JOIN municipality m ON b.parentid = m.objid  
	LEFT JOIN district d ON b.parentid = d.objid 
	LEFT JOIN province p ON m.parentid = p.objid 
	LEFT JOIN city c ON d.parentid = c.objid 
WHERE rp.barangayid = $P{barangayid} 
  AND rp.section LIKE $P{section} 
  AND f.state = 'CURRENT'  
  AND r.taxable = 1 
ORDER BY fullpin   

[getAssessmentRollExempt]
SELECT
	r.ry, rp.section,  
	CASE WHEN p.objid IS NOT NULL THEN p.name ELSE c.name END AS parentlguname, 
	CASE WHEN p.objid IS NOT NULL THEN p.indexno ELSE c.indexno END AS parentlguindex,   
	CASE WHEN m.objid IS NOT NULL THEN m.name ELSE d.name END AS lguname, 
	CASE WHEN m.objid IS NOT NULL THEN m.indexno ELSE d.indexno END AS lguindex,  
	
	b.name AS barangay, b.indexno AS barangayindex, 
	f.owner_name, f.owner_address, 
	f.administrator_name, f.administrator_address, 
	f.tdno, f.effectivityyear, 
	rp.cadastrallotno,  rp.surveyno, rp.blockno, pc.code AS classcode, r.rputype, r.totalav, 
	r.fullpin, f.memoranda, rp.barangayid,
	f.memoranda, et.code AS legalbasis  
FROM faas f
	INNER JOIN rpu r ON f.rpuid = r.objid 
	INNER JOIN realproperty rp ON f.realpropertyid = rp.objid
	INNER JOIN propertyclassification pc ON r.classification_objid = pc.objid 
	INNER JOIN barangay b ON rp.barangayid = b.objid 
	LEFT JOIN exemptiontype et ON r.exemptiontype_objid = et.objid 
	LEFT JOIN municipality m ON b.parentid = m.objid  
	LEFT JOIN district d ON b.parentid = d.objid 
	LEFT JOIN province p ON m.parentid = p.objid 
	LEFT JOIN city c ON d.parentid = c.objid 
WHERE rp.barangayid = $P{barangayid} 
  AND rp.section LIKE $P{section} 
  AND f.state = 'CURRENT'  
  AND r.taxable = 0 
ORDER BY fullpin   