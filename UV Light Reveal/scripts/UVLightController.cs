using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
[ExecuteAlways]
public class UVLighController : MonoBehaviour
{
    private Light uvLight;
    //public Renderer targetRenderer;
     
    void LateUpdate()
    {
        ApplyValues();
    }

    private void Start()
    {
        uvLight = GetComponent<Light>();

       
    }
    void OnValidate()
    {
        ApplyValues();
    }

    void ApplyValues()
    {
        if (!uvLight) return;

        // We sending the data directly to the GPU using "SetGlobal"
        // All material with this variable name on the schene are automatically updated. 
        Shader.SetGlobalVector("_UVLightPos", uvLight.transform.position);
        Shader.SetGlobalVector("_UVLightForward", uvLight.transform.forward.normalized);
        Shader.SetGlobalFloat("_UVLightRange", uvLight.range);

        Shader.SetGlobalFloat("_UVSpotCos", uvLight.spotAngle);
        
    }
}
