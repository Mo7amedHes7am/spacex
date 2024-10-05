using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OutOfBound : MonoBehaviour
{
    GameObject missesObject;

    private void Start()
    {
        missesObject = GameObject.Find("Misses");
    }

    void Update()
    {
        if (transform.position.y < -50)
        {
            Destroy(gameObject);
            Destroy(missesObject.transform.GetChild(0).gameObject);
        }
    }
}
