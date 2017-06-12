// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "ShaderLabStudy/VertexLambert" {
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

			struct a2v
			{
				float4 position : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 position : POSITION;
				fixed3 color : COLOR;
			};

			fixed3 _Color;

			v2f vert(a2v data)
			{
				v2f o;
				o.position = UnityObjectToClipPos(data.position);
				fixed3 worldNormal = -normalize(mul(data.normal, (float3x3)unity_WorldToObject));
				fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
				fixed3 diffuseColor = _LightColor0.xyz * _Color.xyz * saturate(dot(worldNormal, worldLight));
				o.color = diffuseColor;
				return o;
			}

			float4 frag(v2f data) : SV_TARGET
			{
				return fixed4(data.color, 1.0);
			}

			ENDCG
		}
	}
}