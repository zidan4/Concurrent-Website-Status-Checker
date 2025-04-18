require "http/client"

urls = [
  "https://crystal-lang.org",
  "https://example.com",
  "https://github.com"
]

channel = Channel(String).new

urls.each do |url|
  spawn do
    begin
      response = HTTP::Client.get(url)
      channel.send("#{url} → ✅ #{response.status_code}")
    rescue ex
      channel.send("#{url} → ❌ Failed (#{ex.message})")
    end
  end
end

urls.size.times do
  puts channel.receive
end
