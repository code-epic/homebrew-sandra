class SandraSentinel < Formula
  desc "Auditor determinista para nominas militares - Ley Negro Primero"
  homepage "https://github.com/code-epic/sandra.sentinel"
  license "MIT"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/code-epic/sandra.sentinel/releases/download/v1.0.0/sandra-sentinel-aarch64-apple-darwin"
      sha256 "3ba1c1d8727dd385448f822c0c7344ba1dff496463fc35066b0da73909287bdc"
    elsif Hardware::CPU.intel?
      url "https://github.com/code-epic/sandra.sentinel/releases/download/v1.0.0/sandra-sentinel-x86_64-apple-darwin"
      sha256 "87dcf3f276949ed39476356638b0d138523abfd3915506face29afacee2ed62e"
    end
  end

  on_linux do
    url "https://github.com/code-epic/sandra.sentinel/releases/download/v1.0.0/sandra-sentinel-centos8-x86_64"
    sha256 "bb549637d0ee4296aa952865e31533d488733bcb8578ed94d05d3e88cb430ac4"
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
