let screenSize = Vector2.create(400, 300) * 2;

return {
    windowTitle = "Kolanut Game",
    screenSize = screenSize,
    designResolution = Vector2.create(400, 300),
    fullscreen = false,
    graphicBackend = "opengl",
    enableGraphicAPIDebug = false,
    framesInFlight = 1,
    maxGeometryBufferVertices = null,
    enableStats = true,

    mainVertexShaderPath = "shaders/main.vert",
    mainFragmentShaderPath = "shaders/main.frag",
    lineVertexShaderPath = "shaders/main.vert",
    lineFragmentShaderPath = "shaders/solid.frag",
};