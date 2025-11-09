use framework "Foundation"
use framework "AppKit"

property ca : current application

on getNowPlayingInfo()
	set MediaRemote to ca's NSBundle's bundleWithPath:"/System/Library/PrivateFrameworks/MediaRemote.framework"
	MediaRemote's load()
	
	set MRNowPlayingRequest to ca's NSClassFromString("MRNowPlayingRequest")
	set infoDict to MRNowPlayingRequest's localNowPlayingItem()'s nowPlayingInfo()
	
	set trackTitle to (infoDict's valueForKey:"kMRMediaRemoteNowPlayingInfoTitle") as text
	set trackArtist to (infoDict's valueForKey:"kMRMediaRemoteNowPlayingInfoArtist") as text
	set trackAlbum to (infoDict's valueForKey:"kMRMediaRemoteNowPlayingInfoAlbum") as text
	
	set playbackRate to (infoDict's valueForKey:"kMRMediaRemoteNowPlayingInfoPlaybackRate") as real
	set isPlaying to (playbackRate > 0)
	
	if trackTitle is "missing value" then
		return "stopped"
	else
		set output to trackTitle & linefeed
		set output to output & trackArtist & linefeed
		set output to output & trackAlbum & linefeed
		set output to output & isPlaying as text
		
		return output
	end if
end getNowPlayingInfo

try
	return getNowPlayingInfo()
on error
	return "stopped"
end try
