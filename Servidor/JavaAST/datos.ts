class Datos
{
    private estructura:string;
    private tipo:string;
    private nombre:string;
    public lista1:Array<Datos>=new Array<Datos>();

    constructor(estructura:string,tipo:string,nombre:string)
    {
        this.estructura=estructura;
        this.tipo=tipo;
        this.nombre=nombre;
        //let nuevo:Datos_Copias  = new Datos_Copias(estructura,tipo,nombre);
        //this.lista1.push(nuevo);
        //this.agregar(estructura,tipo,nombre);
    }

    public agregar(e:string,t:string,n:string)
    {
        let nuevo:Datos  = new Datos(e,t,n);
        this.lista1.push(nuevo);
    }

    public getEstructura():string
    {
        return this.estructura;
    }

    public getTipo():string
    {
        return this.tipo;
    }

    public getNombre():string
    {
        return this.nombre;
    }

    conca:string="";
    public retornar()
    {
        return this.lista1;
    }
}
export{Datos};