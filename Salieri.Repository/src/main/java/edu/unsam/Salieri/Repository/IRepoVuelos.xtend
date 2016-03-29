package edu.unsam.Salieri.Repository

import edu.unsam.Salieri.Domain.Vuelo
import edu.unsam.Salieri.Domain.VueloBusqueda
import java.util.Date
import java.util.List

interface IRepoVuelos {
	def void agregarVuelo(Vuelo unVuelo)
	def void quitarVuelo(Vuelo unVuelo)
	def List<Vuelo> buscarVuelos(VueloBusqueda vueloBusqueda)
	def List<Vuelo> buscarVuelosConLugar()
	def List<Vuelo> buscarVuelosPorOrigen(String unOrigen,List<Vuelo> resultado)
	def List<Vuelo> buscarVuelosPorDestino(String unDestino,List<Vuelo> resultado)
	def List<Vuelo> buscarVuelosPorRangoDeFechas(Date fechaMin, Date fechaMax,List<Vuelo> resultado)
	def List<Vuelo> buscarVuelosPorMontoMaximo(float montoMaximo,List<Vuelo> resultado)
}