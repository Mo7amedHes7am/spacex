using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class EarthMovement : MonoBehaviour
{

    public ParticleSystem auroraEffect;
    public Transform arCamera;  // Reference to the Sun's transform

    private float orbitSpeed = 10f;  // Speed of the Earth's orbit
    private float distance = 5f;  // Distance of Earth from Sun
    private float rotationSpeed = 20f;  // Speed of Earth's self-rotation

    public GameObject winCanvas;

    void Start()
    {
        // Initialize the Earth's position on the orbit
        if (arCamera != null)
        {
            transform.position = new Vector3(arCamera.position.x + distance, transform.position.y, transform.position.z);
        }
    }

    void Update()
    {
        // Rotate the Earth around the Sun while keeping the Y-axis fixed
        if (arCamera != null && !auroraEffect.isPlaying)
        {
            // Rotate the Earth around the Sun along the Y-axis (up axis)
            transform.RotateAround(arCamera.position, Vector3.up, orbitSpeed * Time.deltaTime);
        }

        transform.Rotate(Vector3.up, rotationSpeed * Time.deltaTime);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Flare"))
        {
            Destroy(other.gameObject); // Destroy Earth after collision
            auroraEffect.Play();
            Invoke(nameof(ShowWinCanvas), 3f);
        }
    }

    void ShowWinCanvas()
    {
        winCanvas.SetActive(true);
    }
}
