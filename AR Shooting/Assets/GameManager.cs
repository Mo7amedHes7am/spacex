using UnityEngine;

public class GameManager : MonoBehaviour
{
    public GameObject misses;
    public GameObject loseCanvas;

    void Update()
    {
        if (misses.transform.childCount <= 0)
        {
            loseCanvas.SetActive(true);
        }
    }

    public void ReloadScene()
    {
        UnityEngine.SceneManagement.SceneManager.LoadScene(UnityEngine.SceneManagement.SceneManager.GetActiveScene().name);
    }


}
