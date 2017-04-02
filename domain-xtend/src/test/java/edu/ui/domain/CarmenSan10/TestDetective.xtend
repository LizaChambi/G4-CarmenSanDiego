package edu.ui.domain.CarmenSan10

import org.junit.Before;
import org.junit.Test;
import org.junit.Assert
import static org.mockito.Mockito.*
import org.omg.CORBA.UserException

class TestDetective 
{
	Detective detective
	Villano villanoMock
	Pais italiaMock
	Pais alemaniaMock
	
	@Before
	def void setUp() {
		detective = new Detective ()
		villanoMock = mock(Villano)
		italiaMock = mock(Pais)
		alemaniaMock = mock(Pais)
		when(italiaMock.nombrePais).thenReturn("Italia")
		when(alemaniaMock.nombrePais).thenReturn("Alemania")
	}
	
	/**
	 * Dado un detective con una orden de arresto vigente...
	 * pregunta si hay una orden de arresto vigente y... 
	 * devuelve True.
	 */
	@Test
	def void testTieneOrdenDeArrestoCasoPositivo ()
	{
		when(villanoMock.nombre).thenReturn("Carmen Sandiego")
		
		detective.ordenarArresto(villanoMock)
		
		Assert.assertTrue(detective.tieneUnaOrdenDeArresto)
	}
	
	/**
	 * Daso un detective sin una orden de arresto...
	 * pregunta si hay una orden de arresto vigente y... 
	 * devuelve False
	 */
	@Test
	def void testTieneOrdenDeArrestoCasoNegativo ()
	{
		when(villanoMock.nombre).thenReturn("Carmen Sandiego")
		
		Assert.assertFalse(detective.tieneUnaOrdenDeArresto)
	}
	
	/**
	 * El detective emite una orden de arresto para "Carmen Sandiego"...
	 * y verifica si la orden es para "Carmen Sandiego"...
	 * Devuelve True.
	 */
	@Test
	def void testOrdenarArrestoCasoPositivo ()
	{
		when(villanoMock.nombre).thenReturn("Carmen Sandiego")
		
		detective.ordenarArresto(villanoMock)
		
		Assert.assertEquals(detective.ordenDeArresto,"Carmen Sandiego")
	}
	
	/**
	 * El detective emite una orden de arresto para "Ivan Noseque"...
	 * y verifica si la orden es para "Carmen Sandiego"...
	 * Devuelve False.
	 */
	@Test
	def void testOrdenarArrestoCasoNegativo ()
	{
		when(villanoMock.nombre).thenReturn("Ivan Noseque")
		
		detective.ordenarArresto(villanoMock)
		
		Assert.assertNotEquals(detective.ordenDeArresto,"Carmen Sandiego")
	}
	
	/**
	 * El detective viaja a Italia y verifica que se encuentre en Italia,
	 * Luego viaja a Alemania y verifica que se encuentre en Alemania.
	 */
	@Test
	def void testViajarA ()
	{
		detective.viajarA(italiaMock)
		
		Assert.assertEquals(detective.ubicacionActual.nombrePais,"Italia")
		
		detective.viajarA(alemaniaMock)
		
		Assert.assertEquals(detective.ubicacionActual.nombrePais,"Alemania")
		
	}
	
	/**
	 * Dado un detective en Alemania con conexiones aereas a Italia...
	 * intenta viajar a Italia...
	 * Devuelve true
	 */
	@Test
	def void testViajarSiPuedeAUnCasoPositivo ()
	{
		when(alemaniaMock.tieneConexionAereaCon(italiaMock)).thenReturn(true)
		
		detective.viajarA(alemaniaMock)
		detective.viajarSiPuedeA(italiaMock)
		
		Assert.assertEquals(detective.ubicacionActual.nombrePais,"Italia")
	}
	
	/**
	 * Dado un detective en Alemania sin conexiones aereas a Italia...
	 * intenta viajar a Italia...
	 * Devuelve un Excepcion
	 */
	@Test (expected=UserException)
	def void testViajarSiPuedaAUnCasoNegativo ()
	{
		when(alemaniaMock.tieneConexionAereaCon(italiaMock)).thenReturn(false)
		
		detective.viajarA(alemaniaMock)
		detective.viajarSiPuedeA(italiaMock)
	}
	
	/**
	 * El detective viaja a Italia y luego a Alemania...
	 * regresa al pais anterior...
	 * y verifica que este de nuevo en Italia.
	 */
	@Test
	def void regresarAlPaisAnterior ()
	{
		detective.viajarA(italiaMock)
		detective.viajarA(alemaniaMock)
		detective.regresarAlPaisAnterior
		
		Assert.assertEquals(detective.ubicacionActual.nombrePais,"Italia")
	}
	
	/**
	 * El detective viaja a Italia y luego a Alemania...
	 * Cuando intenta regresa al pais anterior...
	 * Regresa a Italia y lo verifica.
	 */
	@Test
	def void regresarAlPaisAnteriorSiPuedeAUnCasoPositivo ()
	{	
		detective.viajarA(italiaMock)
		detective.viajarA(alemaniaMock)
		detective.regresarAlPaisAnteriorSiPuede
		
		Assert.assertEquals(detective.ubicacionActual.nombrePais,"Italia")
	}
	
	/**
	 * El detective viaja solo a Italia...
	 * Cuando intenta regresar al pais anterior...
	 * Devuelve un Excepcion
	 */
	@Test (expected=UserException)
	def void regresarAlPaisAnteriorSiPuedeAUnCasoNegativo ()
	{
		when(italiaMock.nombrePais).thenReturn("Italia")
		
		detective.viajarA(italiaMock)
		detective.regresarAlPaisAnteriorSiPuede	
	}
	
	/**
	 * El detective viaja a Alemania, Italia y Austria
	 * Cuando pregunta cuantos paises recorrio...
	 * Devuelve 3.
	 */
	@Test
	def void testCantidadDePaisesRecorridos ()
	{
		var Pais austriaMock = mock(Pais)
		when(austriaMock.nombrePais).thenReturn("Austria")
		
		detective.viajarA(alemaniaMock)
		detective.viajarA(italiaMock)
		detective.viajarA(austriaMock)

		Assert.assertEquals(detective.cantidadDePaisesRecorridos,3)
	}
	
}