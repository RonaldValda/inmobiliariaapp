class TipoInmueble{
  String _id="";
  String _tipo="";
  TipoInmueble(this._id,this._tipo);
  
  get getId=>this._id;
  get getTipo=>this._tipo;
  TipoInmueble.map(dynamic obj){
    this._tipo=obj["tipo"];
  }
  TipoInmueble.empty();

  void setId(String id) {
    this._id=id;
  }
  void setTipo(String tipo){
    this._tipo=tipo;
  }
}