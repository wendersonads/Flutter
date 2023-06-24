function mudaFoto(foto) {
    document.getElementById("icone").src = foto;
}
function acre() {
    var cidade = new Option("Rio Branco");
    document.getElementById('ccidade').add(cidade);
    cidade = new Option("Acrelândia");
    document.getElementById('ccidade').add(cidade);
    cidade = new Option("Assis Brasil");
    document.getElementById('ccidade').add(cidade);
    cidade = new Option("Brasiléia");
    document.getElementById('ccidade').add(cidade);
    cidade = new Option("Bujari");
    document.getElementById('ccidade').add(cidade);
}
function goias() {
    var cidade = new Option("Goiânia");
    document.getElementById('ccidade').add(cidade);
    cidade = new Option("Abadia de Goiás");
    document.getElementById('ccidade').add(cidade);
    cidade = new Option("Abadiânia");
    document.getElementById('ccidade').add(cidade);
    cidade = new Option("Acreúna");
    document.getElementById('ccidade').add(cidade);
    cidade = new Option("Adelândia");
    document.getElementById('ccidade').add(cidade);
   }
   

function busca_cidades() {
    var estado = document.getElementById("cuf").value;
    var lista = document.getElementById("ccidade");
    while (lista.options.length) {
        lista.remove(0);
    }
    if (estado == "AC") {
        acre();
    } else {
        if (estado == "AL") {
            alagoas();
        } else {
            if (estado == "AM") {
                amazonas();
            } else {
                if (estado == "AP") {
                    amapa();
                } else {
                    if (estado == "BA") {
                        bahia();
                    } else {
                        if(estado == "GO"){
                            goias();
                        }
                    }
                }
            }
        }
    }
}


