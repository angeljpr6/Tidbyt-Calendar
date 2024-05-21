"""
Applet: Calendar App
Summary: Show a calendar
Description: Show the next events in your google calendar.
Author: angeljpr
"""
load("render.star", "render")
load("http.star", "http")

# Url de la api que se encarga de conectar con googleCalendar
API_BASE_URL = "http://127.0.0.1:8000"

def main(config):

    # Obtenemos los proximos eventos
    events = getEvents()

    # Cuando la api no encuentra ningun evento en el calendario devuelve este string por lo que comprobamos el contenido de events
    if events == "No se encontraron próximos eventos.":

        return renderNoEvents()

    else:


        children = []

        lastDay = 0

        # Recorremos todos los eventos del calendario para guardalos en un array y poder mostrarlos todos
        for event in events:
            summary = str(event["summary"])
            start = str(event["start"])
            startMonth = start[5:7]
            startDay = start[8:10]
            startHour = start[11:16]
            
            # Guardamos en children todos los eventos con el formato para mostrarlos en la pantalla
            children.append(renderPrincipal(summary, startDay, startMonth, startHour, lastDay))

            # Guardamos el dia del evento anterior para poder agrupar los eventos por dia
            lastDay = startDay

        return render.Root(
            delay=1,
            child=render.Marquee(
                render.Column(
                    children=children
                ),
                height=30,
                scroll_direction="vertical"
            )
        )

# Esta funcion devuelve un render que muestra un texto para el caso de no haber eventos en tu calendario en las proximas 24 horas
def renderNoEvents():
    return render.Root(
        
        #Creamos los varios box uno para el fondo de toda la pantalla y el siguiente para aplicar un fondo al texto
        child=render.Box(
            color="#4D747E",
            child=render.Column(
                expanded=True,
                cross_align="center",
                main_align="center",
                children=[
                    render.Box(
                        height=24,
                        width=40,
                        color="#7C1034",
                        child=render.Column(
                            cross_align="center",
                            main_align="center",
                            children=[
                                render.Text("!TIENES"),
                                render.Text("EL DIA"),
                                render.Text("LIBRE!")
                            ]
                        )
                    ),
                ]
            )
        )
    )

# Aqui pasamos los datos de cada evento a un render para mostarlos en la pantalla
def renderPrincipal(summary, startDay, startMonth, startHour, lastDay):

    # En caso de que el dia del evento anterior no coincida con el del evento actual mostraremos arriba de este el dia en el que esta planeado el evento
    # si coincide con el dia del evento anterior simplemente mostraremos la hora y el nombre del evento para asi poderlos agrupar por dias 
    if lastDay==0 or lastDay != startDay:
        return render.Column(
            children=[

                # Aqui mostramos el dia en el que sucede el evento
                render.Box(
                    child=render.Row(
                        children=[
                            render.Text(
                                content=startDay+"/"+startMonth+" ",
                                color="#FFC300"
                            ),
                        ],
                    ),
                    color="#000000",
                    height=8
                ),
                # Por aqui mostramos la hora y nombre del evento
                render.Box(
                    child=render.Column(
                        children=[
                            render.Row(
                                children=[
                                    render.Text(
                                        content=startHour+"h",
                                        color="#00D56D",
                                    ),
                                    render.Text(
                                        content=summary[0:7].upper(),
                                        color="#CFE5FF"
                                    )
                                ],
                                expanded = True,
                                main_align = "start"
                            ),
                            render.Text(summary[7:].upper())
                        ]
                    ),
                    #La altura del box la calculamos en base al numero de caracteres del nombre del evento para poder ampliarlo de ser necesario
                    height=calculateHeight(summary),
                    color="#7C1034"
                )
            ]
        )
    # Aqui se muestran tan solo la hora y el nombre del evento ya que coincide con la fecha del anterior
    else:
        return render.Column(
            children=[
                render.Box(
                    child=render.Column(
                        children=[
                            render.Row(
                                children=[
                                    render.Text(
                                        content=startHour+"h",
                                        color="#00D56D",
                                    ),
                                    render.Text(
                                        content=summary[0:7].upper(),
                                        color="#CFE5FF"
                                    )
                                ],
                                expanded = True,
                                main_align = "start"
                            ),
                            render.Text(summary[7:].upper())
                        ]
                    ),
                    #La altura del box la calculamos en base al numero de caracteres del nombre del evento para poder ampliarlo de ser necesario
                    height=calculateHeight(summary),
                    color="#7C1034"
                )
            ]
        )
        
# Para poder ampliar el box del nombre del evento cuando este sea muy largo comprobamos el numero de caracteres y de ser necesario lo ampliaremos a dos lineas
def calculateHeight(summary):
    if len(summary)>7:
        return 16
    else:
        return 8


# Esta funcion realiza una consulta a la api que devuelve todos los eventos proximos desde la hora actual hasta dentro de 24 horas
def getEvents():

    # rep sera igual al contenido que devuelva la api
    rep = http.get(API_BASE_URL + "/nextEvent")

    # Si de conecta bien con la api pasamos la respuesta a json y la devolvemos si no devolvemos un error
    if rep.status_code == 200:
        event = rep.json()
        return event
    else:
        return "Error al conectar con la API"    