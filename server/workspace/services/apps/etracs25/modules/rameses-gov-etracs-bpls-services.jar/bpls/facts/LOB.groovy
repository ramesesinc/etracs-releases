package bpls.facts;

public class LOB {
    
    BPApplication application;
    String objid; 			
    String lobid;			
    String name;
    String classification;
    String attributes;
    String assessmenttype;
    
    /** Creates a new instance of LOB */
    public LOB() {
    }

    public LOB(def o) {
        this.objid = o.lobid;
        this.lobid = o.lobid;
        this.assessmenttype = o.assessmenttype;  
    }

    public void printInfo() {
        /*print lob*/
        println "Lob Fact"
        println "objid " + this.objid;
        println "lobid " + this.lobid;
        println "assessment type " + this.assessmenttype;  
    }

}
