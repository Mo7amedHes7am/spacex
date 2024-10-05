using UnityEngine;
using Vuforia;


public class Shoot : MonoBehaviour
{
    public GameObject solarFlarePrefab;
    public float shootForce = 1000f;

    public float cooldownTime = 3.0f;  // Time in seconds between shots
    private bool canShoot = true;      // Boolean to track if the gun can shoot

    public GameObject misses;

    void Update()
    {
        if (Input.GetMouseButtonDown(0) && canShoot && misses.transform.childCount > 0) // Or use a button click for mobile
        {
            canShoot = false;
            ShootSolarFlare();
            Invoke(nameof(ResetCoolDown), cooldownTime);
        }
    }

    void ShootSolarFlare()
    {
        GameObject flare = Instantiate(solarFlarePrefab, transform.position, transform.rotation);
        Rigidbody rb = flare.GetComponent<Rigidbody>();
        rb.AddForce(Camera.main.transform.forward * shootForce);
    }

    void ResetCoolDown()
    {
        canShoot = true;
    }

}
