ventana = {

    ancho = 200,
    alto = 150,
    escala = 4
}

jugador = {
    
    x = 0,
    y = 0,
    centro_x = 0,
    centro_y = 0,
    velocidad = 50,
    sprite = nil
}


function love.load()

    love.window.setMode(ventana.ancho * ventana.escala, ventana.alto * ventana.escala)

    love.graphics.setDefaultFilter("nearest", "nearest")
    jugador.sprite = love.graphics.newImage("img/Walk.png")

    jugador.centro_x = jugador.sprite:getWidth() / 2
    jugador.centro_y = jugador.sprite:getHeight() / 2

    lienzo = love.graphics.newCanvas(ventana.ancho,ventana.alto)
end

function love.update(dt)
    

      if love.keyboard.isDown("right") then

        jugador.x = jugador.x + (jugador.velocidad * dt)
       
    elseif love.keyboard.isDown("left") then

        jugador.x = jugador.x - (jugador.velocidad * dt)
        
    elseif love.keyboard.isDown("up") then

        jugador.y = jugador.y - (jugador.velocidad * dt)
       
    elseif love.keyboard.isDown("down") then

        jugador.y = jugador.y + (jugador.velocidad * dt)
        
    end
end

function love.draw()
   
    love.graphics.setCanvas(lienzo)
         
    love.graphics.clear()
    love.graphics.draw(jugador.sprite,jugador.x,jugador.y, 0, 1, 1, jugador.origen_x,jugador.origen_y)

    love.graphics.setCanvas()

    love.graphics.draw(lienzo, 0, 0, 0, ventana.escala, ventana.escala)

end
