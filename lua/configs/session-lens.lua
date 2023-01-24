local status_ok, autosession = pcall(require, "auto-session")
if not status_ok then
 return
end

autosession.setup({
  auto_session_suppress_dirs = {'~/.config/nvim/session'}
})
