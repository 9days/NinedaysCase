package
{
	import com.gf.app.MainEntry;

	[SWF(backgroundColor=0x555555, frameRate="30", width="800", height="760")]
	public class GFCase extends ninedaysCase
	{
		public function GFCase()
		{
			var entry:MainEntry = new MainEntry();
			entry.setup(this);
		}
	}
}