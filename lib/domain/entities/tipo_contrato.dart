class TipoContrato{
  String _id="";
  String _tipoContrato="";
  TipoContrato(this._id,this._tipoContrato);
  get getId=>this._id;
  get getTipoContrato=>this._tipoContrato;
  void setId(String id)=>this._id=id;
  void setTipoContrato(String tipoContrato)=>this._tipoContrato=tipoContrato;
}