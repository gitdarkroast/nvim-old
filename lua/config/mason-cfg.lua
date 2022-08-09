local status_ok, m = pcall(require, "mason")
if not status_ok then
    return
end

m.setup()
