cask "simlease" do
  version "1.1.0"
  sha256 "8e004999c72f3525ae637dc8bd97865364e9ca5e24e3119778ee1f25d63f472f"

  url "https://github.com/motystudio/SimLease/releases/download/v#{version}/SimBar-#{version}.zip"
  name "SimLease"
  name "SimBar"
  desc "Share simulators and emulators between parallel Claude Code sessions"
  homepage "https://github.com/motystudio/SimLease"

  livecheck do
    url "https://github.com/motystudio/SimLease/releases/latest/download/appcast.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  depends_on macos: :sequoia

  app "SimBar.app"
  binary "#{appdir}/SimBar.app/Contents/Resources/sim-lease"

  uninstall quit: "com.motystudio.simbar"

  zap trash: [
    "~/.claude/CLAUDE.md.backup-simbar",
    "~/.claude/settings.json.backup-simbar",
    "~/.claude/sim-lease.conf",
    "~/.claude/sim-leases",
    "~/Library/Caches/com.motystudio.simbar",
    "~/Library/HTTPStorages/com.motystudio.simbar",
    "~/Library/Preferences/com.motystudio.simbar.plist",
  ]

  caveats <<~EOS
    Open SimBar once to finish the setup: its setup assistant installs
    ~/.claude/bin/sim-lease, the <simulators> rule in ~/.claude/CLAUDE.md and the
    SessionEnd hook that releases a session's devices.
      open -a SimBar
  EOS
end
