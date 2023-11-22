object Arma {
    var potencia = 0
    var desgastada = false

    method usar() {
        desgastada = true
    }

    method reparar() {
        desgastada = false
    }
}

object SableDeLuz {
    var energia = 0
}

class Soldado {
    var valentia = 0
    var inteligencia = 0
    var armas = []

    method calcularPoder() {
        return valentia + inteligencia + armas.filter(arma => !arma.desgastada).sumBy(arma => arma.potencia)
    }

    method tomarArma(arma) {
        armas.add(arma)
    }

    method dejarArma(arma) {
        armas.remove(arma)
    }

    method usarArma(arma) {
        if (armas.contains(arma)) {
            arma.usar()
        }
    }

    method repararArma(arma) {
        if (armas.contains(arma)) {
            arma.reparar()
        }
    }
}

class Maestro {
    var valentia = 0
    var inteligencia = 0
    var midiclorianos = 0
    var sableDeLuz = SableDeLuz

    method calcularPoder()
}

class Jedi inherits Maestro {
    var tiempoEnLadoLuminoso = 0

    method calcularPoder() = valentia + inteligencia + midiclorianos * 0.001 + sableDeLuz.energia * tiempoEnLadoLuminoso
    
    override method vivirSuceso(cargaEmocional) {
        if (cargaEmocional >= tiempoEnLadoOscuro) {
            tiempoEnLadoOscuro = 0
            tiempoEnLadoLuminoso++
        } else {
            tiempoEnLadoLuminoso++
        }
    }
}

class Sith inherits Maestro {
    var tiempoEnLadoOscuro = 0
    var odio = 0

    method calcularPoder() {
        return valentia + inteligencia + 2 * sableDeLuz.energia + tiempoEnLadoOscuro * 0.1 * odio
    }

    override method vivirSuceso(cargaEmocional) {
        odio += cargaEmocional * 0.1
        tiempoEnLadoOscuro++
        if (cargaEmocional > odio) {
            tiempoEnLadoOscuro = 0
            tiempoEnLadoLuminoso++
            odio = 0
        }
    }
}

class Planeta {
    var habitantes = []

    method calcularPoderTotal() {
        return habitantes.sumBy(h | h.calcularPoder())
    }

    method tieneOrden() {
        var maestrosPoderosos = habitantes.sortBy(habitante => -habitante.calcularPoder()).take(3)
        var mitadPoderTotal = calcularPoderTotal() / 2

        return maestrosPoderosos.sumBy(maestro => maestro.calcularPoder()) > mitadPoderTotal
    }
  }
