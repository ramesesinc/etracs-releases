package rptis.bldg.facts;
import java.math.*;

public class BldgAdjustment
{

    BldgFloor   bldgfloor
    BldgUse     bldguse 
    String      additionalitemid
    String      additionalitemcode
    String      adjtype         //values: addlitem, adjustment
    Double      amount
    String      expr


    //data reference
    def entity

    public BldgAdjustment(){}

    public BldgAdjustment(bldguse, bldgfloor, adj){
        this.entity         = adj
        this.bldguse        = bldguse 
        this.bldgfloor      = bldgfloor
        this.additionalitemid = adj.additionalitem?.objid
        this.additionalitemcode = adj.additionalitem?.code
        this.adjtype          = adj.additionalitem?.type

        setAmount(0.0)
        setExpr(adj.additionalitem?.expr)
    }

    void setAmount( amount ){
        this.amount = amount
        entity.amount = new BigDecimal(amount+'')
    }

    void setExpr( expr ){
        this.expr = expr
        entity.expr = expr
    }

    public Map getParams(){
        Map p = [:]
        entity.params?.each {
            def value = parseInt(it.intvalue)
            if (it.param.paramtype.matches('.*decimal.*'))
                value = parseDouble(it.decimalvalue)
            p[it.param.name] = value
        }
        return p 
    }    

    def parseInt(val){
        try{
            return new java.math.BigDecimal(val+'').intValue();
        }
        catch(e){
            return 0;
        }
    }

    def parseDouble(val){
        try{
            return new BigDecimal(val+'')
        }
        catch(e){
            return 0.0;
        }
    }


    void resetValue(){
        entity.params.each{
            it.decimalvalue = 0.0
            it.intvalue = 0
        }
    }



}
