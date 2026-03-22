class SandraSentinel < Formula
  desc "Auditor determinista para nóminas militares - Ley Negro Primero"
  homepage "https://github.com/code-epic/sandra.sentinel"
  license "MIT"
  version "VERSION_PLACEHOLDER"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/code-epic/sandra.sentinel/releases/download/vVERSION_PLACEHOLDER/sandra-sentinel-aarch64-apple-darwin"
      sha256 "SHA256_PLACEHOLDER # sandra-sentinel-aarch64-apple-darwin"
    elsif Hardware::CPU.intel?
      url "https://github.com/code-epic/sandra.sentinel/releases/download/vVERSION_PLACEHOLDER/sandra-sentinel-x86_64-apple-darwin"
      sha256 "SHA256_PLACEHOLDER # sandra-sentinel-x86_64-apple-darwin"
    end
  end

  on_linux do
    url "https://github.com/code-epic/sandra.sentinel/releases/download/vVERSION_PLACEHOLDER/sandra-sentinel-centos8-x86_64"
    sha256 "SHA256_PLACEHOLDER # sandra-sentinel-centos8-x86_64"
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "sandra-sentinel-aarch64-apple-darwin" => "sandra-sentinel"
    elsif OS.mac? && Hardware::CPU.intel?
      bin.install "sandra-sentinel-x86_64-apple-darwin" => "sandra-sentinel"
    elsif OS.linux?
      bin.install "sandra-sentinel-centos8-x86_64" => "sandra-sentinel"
    end
  end

  test do
    system "#{bin}/sandra-sentinel", "--version"
  end
end
