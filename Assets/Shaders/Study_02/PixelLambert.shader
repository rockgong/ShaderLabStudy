Shader "ShaderLabStudy/PixelLambert" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
	}
	SubShader {
		Pass
		{
		CGPROGRAM

		#pragma vertex vert
		#pragma fragment frag

		#include "Lighting.cginc"

		fixed3 _Color;

		struct a2v
		{
			float4 position : POSITION;
			float3 normal : NORMAL;
		};

		struct v2f
		{
			float4 position : POSITION;
			float3 normal : TEXCOORD0;
		};

		v2f vert(a2v i)
		{
			v2f o;

			o.position = UnityObjectToClipPos(i.position);
			o.normal = normalize(mul(i.normal, (float3x3)unity_WorldToObject));

			return o;
		}

		float4 frag(v2f i) : SV_TARGET
		{
			fixed3 worldNormal = -i.normal;
			fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
			fixed3 result = _LightColor0 * _Color * saturate(dot(worldNormal, worldLight));
			return float4(result.xyz, 1.0);
		}

		ENDCG
		}
	}
	FallBack "Diffuse"
}
